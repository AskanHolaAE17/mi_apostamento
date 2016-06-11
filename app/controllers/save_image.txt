    #attach = params[:contact][:image].tempfile.read
    #contact.image = Base64.encode64 attach
    #contact.save
        
    contact.image_data          = params[:contact][:image_data].read 
    contact.image_file_name     = params[:contact][:image_data].original_filename
    contact.image_content_type  = params[:contact][:image_data].content_type
    
    
    
  require 'net/http'
  require 'json'

  @host = 'www.googleapis.com'
  @port = '8099'

  @path = '/upload/drive/v2/files?uploadType=multipart'

  @body ={
    "bbrequest" => "BBTest",
    "reqid" => "44",
    "data" => {"name" => "test"}
  }.to_json

  request = Net::HTTP::Post.new(@path, initheader = {'Content-Type' =>'multipart/related'})
  request.body = @body
  response = Net::HTTP.new(@host, @port).start {|http| http.request(request) }
  #puts "Response #{response.code} #{response.message}: #{response.body}"    

