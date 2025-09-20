function load_note_data(path) {
	if(!file_exists(path))
	{
		error("Song File does not exist. : " + path);
		return noone;
	}
	
	var csv_data = load_csv(path)
	var rows = ds_grid_height(csv_data);
	
	var data;
	for(var i = 0; i < rows; i++)
	{
	    var rotation = real(csv_data[#0, i]);
	    var beat = real(csv_data[#1, i]);
	    var changeSpeed = real(csv_data[#2, i]);
			
		data[i] =  { rotation: rotation, beat: beat, changeSpeed: changeSpeed };
	}

	log("Song Successfully Loaded : " + path);
	return data;
}