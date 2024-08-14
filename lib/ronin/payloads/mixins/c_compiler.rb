# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2024 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# ronin-payloads is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-payloads is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-payloads.  If not, see <https://www.gnu.org/licenses/>.
#

module Ronin
  module Payloads
    module Mixins
      #
      # Mixin for using the C compiler.
      #
      # ## Features
      #
      # * Supports `gcc` and `clang`.
      # * Supports automatically switching to a cross compiler to cross compile
      #   for different architectures and OSes.
      # * Supports using `mingw32` to cross-compile for Windows.
      #
      # @since 0.2.0
      #
      module CCompiler
        #
        # The default C compiler.
        #
        # @return [String, nil]
        #
        # @api private
        #
        def self.cc
          ENV['CC']
        end

        #
        # Adds the `cc`, `c_compiler`, `arch`, `vendor`, and `os` params
        # to the payload class that included {Mixins::CCompiler}.
        #
        # @param [Class<Payload>] payload_class
        #   The payload class including {Mixins::CCompiler}.
        #
        # @api private
        #
        def self.included(payload_class)
          payload_class.param :cc, default:  -> { cc },
                                   desc:     'The C compiler command to use'

          payload_class.param :c_compiler, Core::Params::Types::Enum[
                                             :gcc,
                                             :clang
                                           ], default: :gcc,
                                              desc:    'The C compiler to use'

          payload_class.param :arch, Core::Params::Types::Enum[
                                       :"x86-64",
                                       :i686,
                                       :aarch64,
                                       :arm,
                                       :arm64,
                                       :armbe,
                                       :armbe64,
                                       :mips,
                                       :mips64,
                                       :ppc,
                                       :ppc64
                                     ], desc: 'The target architecture'

          payload_class.param :vendor, Core::Params::Types::Enum[
                                         :pc,
                                         :unknown
                                       ], desc: 'The target vendor'

          payload_class.param :os, Core::Params::Types::Enum[
                                     :linux,
                                     :macos,
                                     :freebsd,
                                     :windows,
                                     :"windows-gnu",
                                     :"windows-msvc"
                                   ], desc: 'The target OS'
        end

        #
        # The target architecture to compile for.
        #
        # @return [String]
        #   The target architecture string.
        #
        # @api private
        #
        def target_arch
          if params[:arch]
            params[:arch].to_s.tr('-','_')
          end
        end

        #
        # The target vendor to compile for.
        #
        # @return [String]
        #   The target vendor string.
        #
        # @api private
        #
        def target_vendor
          if params[:os] == :windows
            'w64'
          elsif params[:vendor]
            params[:vendor].to_s
          end
        end

        #
        # The target OS to compile for.
        #
        # @return [String]
        #   The target OS string.
        #
        # @api private
        #
        def target_os
          case params[:os]
          when :linux   then 'linux-gnu'
          when :windows then 'mingw32'
          else               params[:os].to_s
          end
        end

        #
        # The target platform to compile for.
        #
        # @return [String, nil]
        #   The target triple string, if the `arch` and `os` params are set.
        #
        # @api private
        #
        def target_platform
          arch = target_arch
          os   = target_os

          if arch && os
            if (vendor = target_vendor)
              "#{arch}-#{vendor}-#{os}"
            else
              "#{arch}-#{os}"
            end
          end
        end

        #
        # The C compiler command to use.
        #
        # @return [String]
        #   The command name.
        #
        # @api private
        #
        def cc
          params[:cc] || case params[:c_compiler]
                         when :gcc
                           if (target = target_platform)
                             "#{target}-gcc"
                           else
                             'gcc'
                           end
                         when :clang then 'clang'
                         else             'cc'
                         end
        end

        #
        # Compiles one or more source files using `cc`.
        #
        # @param [Array<String>] source_files
        #   The source file(s) to compile.
        #
        # @param [String] output
        #   The output file path.
        #
        # @param [Array<String>, Hash{Symbol,String => String}, nil] defs
        #   Additional macro definitions to pass to the compiler.
        #
        # @param [Array<String>] libs
        #   Libraries to link to.
        #
        # @raise [ArgumentError]
        #   `defs` was not an Array or a Hash.
        #
        # @raise [BuildFailed]
        #   The `cc` command failed or is not installed.
        #
        def compile_c(*source_files, output: , defs: nil, libs: nil)
          target = target_platform
          args   = [cc]

          if target && params[:c_compiler] == :clang
            args << '-target' << target
          end

          if defs
            case defs
            when Array
              defs.each do |value|
                args << "-D#{value}"
              end
            when Hash
              defs.each do |name,value|
                args << "-D#{name}=#{value}"
              end
            else
              raise(ArgumentError,"defs must be either an Array or a Hash: #{defs.inspect}")
            end
          end

          args << '-o' << output
          args.concat(source_files)

          if libs
            libs.each do |lib|
              args << "-l#{lib}"
            end
          end

          case system(*args)
          when false
            raise(BuildFailed,"#{cc} command failed: #{args.join(' ')}")
          when nil
            raise(BuildFailed,"#{cc} command not installed")
          end
        end

        alias compile compile_c
      end
    end
  end
end
