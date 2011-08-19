class TestController < ApplicationController
  def download
    send_file("/tmp/multimethods.pdf",
              :filename => "multi-methods.pdf",
              :type     => "application/pdf")
  end

end
