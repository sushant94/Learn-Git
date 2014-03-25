require 'json'

class Directory

  def initialize
  end

  def get_files_in_directory path , prefix , child
   Dir.foreach(prefix+path) do |entry|
      if entry == "." || entry == ".." || entry[0] == "."
        next
      elsif(File::directory?(prefix+path+'/'+entry))
        childrens = []
        get_files_in_directory entry, prefix+path+"/" , childrens
        child << {data: entry,children: childrens}
      else
        tmp_hash = {data: entry}
        child << tmp_hash
      end
    end
  child
  end

  def get_content prefix,file_path
    #Check if he is autorized to do so
    if File.file?(prefix+file_path)
      f = File.open(prefix+file_path,"r+")
    end
  end

  def save_content prefix,file_path,content
    #CHECK THE AUTHORIZATION BASED ON THE URL!!
    f = File.open(prefix+file_path,"w+")
    f.puts content
    f.close
  end

end
