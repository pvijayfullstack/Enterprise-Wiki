class TestController < ApplicationController
  def download
    send_file "/tmp/multimethods.pdf", :filename => "multi-methods.pdf"
  end
  
  def upload
    @the_file = params[:somefile]
  end

end
