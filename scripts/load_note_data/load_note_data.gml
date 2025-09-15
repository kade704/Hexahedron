function load_note_data(path) {
	var data;
	data[0] = { rotation: 0, beat: 1, changeSpeed: 1 };

	if(file_exists(path))
	{
	    var file = file_text_open_read(path);    

	    for(var i = 1; !file_text_eof(file); i++)
	    {
	        var rotation = file_text_read_real(file);
	        var beat = file_text_read_real(file);
	        var changeSpeed = file_text_read_real(file);
	        file_text_readln(file);
			
			data[i] =  { rotation: rotation, beat: beat, changeSpeed: changeSpeed };
	    }
	    file_text_close(file);
    
	    log("File Successfully Loaded : " + path);
	}
	else 
	{
	    error("File does not exist. : " + path);
	}
	
	return data;
}