function load_model(argument0) {
	var _name = argument0;

	if(file_exists(_name))
	{
	    var _file = file_text_open_read(_name);
    
	    var _vertices = noone;
	    var _texcoord = noone;
	    var _normals = noone;
	    var _indices = noone;
    
	    var _vertexCount = 0;
	    var _texcoordCount = 0;
	    var _normalCount = 0;
	    var _indexCount = 0;
    
	    while(!file_text_eof(_file))
	    {
	        var _string = file_text_read_string(_file);
        
	        var _header = string_copy(_string, 1, 2);
        
	        if(_header == "v ")
	        {   
	            var _s = string_split(string_delete(_string, 1, 2), " ");
	            _vertices[_vertexCount, 0] = real(_s[0]);
	            _vertices[_vertexCount, 1] = real(_s[1]);
	            _vertices[_vertexCount, 2] = real(_s[2]);
	            _vertexCount++;
	        }
	        else if(_header == "vt")
	        {
	            var _s = string_split(string_delete(_string, 1, 3), " ");
	            _texcoord[_texcoordCount, 0] = real(_s[0]);
	            _texcoord[_texcoordCount, 1] = real(_s[1]);
	            _texcoordCount++;
	        }
	        else if(_header == "vn")
	        {
	            var _s = string_split(string_delete(_string, 1, 3), " ");
	            _normals[_normalCount, 0] = real(_s[0]);
	            _normals[_normalCount, 1] = real(_s[1]);
	            _normals[_normalCount, 2] = real(_s[2]);
	            _normalCount++;
	        }
	        else if(_header == "f ")
	        {
	            var _s = string_split(string_delete(_string, 1, 2), " ");
            
	            var _v1 = string_split(_s[0], "/");
	            _indices[_indexCount, 0] = real(_v1[0]);
	            _indices[_indexCount, 1] = real(_v1[1]);
	            _indices[_indexCount, 2] = real(_v1[2]);
	            _indexCount++;
            
	            var _v2 = string_split(_s[1], "/");
	            _indices[_indexCount, 0] = real(_v2[0]);
	            _indices[_indexCount, 1] = real(_v2[1]);
	            _indices[_indexCount, 2] = real(_v2[2]);
	            _indexCount++;
            
	            var _v3 = string_split(_s[2], "/");
	            _indices[_indexCount, 0] = real(_v3[0]);
	            _indices[_indexCount, 1] = real(_v3[1]);
	            _indices[_indexCount, 2] = real(_v3[2]);
	            _indexCount++;
	        }
	        else {}

	        file_text_readln(_file);
	    }
	    file_text_close(_file);
    
	    vertex_format_begin();
	    vertex_format_add_position_3d();
	    vertex_format_add_textcoord();
	    vertex_format_add_normal();
	    var _format = vertex_format_end();
    
	    var _buffer = vertex_create_buffer();
	    vertex_begin(_buffer, _format);
	    for(var i = 0; i < _indexCount; i++)
	    {
	        vertex_position_3d(_buffer, _vertices[_indices[i, 0] - 1, 0], _vertices[_indices[i, 0] - 1, 1], _vertices[_indices[i, 0] - 1, 2]);
	        vertex_texcoord(_buffer, _texcoord[_indices[i, 1] - 1, 0], _texcoord[_indices[i, 1] - 1, 1]);
	        vertex_normal(_buffer, _normals[_indices[i, 2] - 1, 0], _normals[_indices[i, 2] - 1, 1], _normals[_indices[i, 2] - 1, 2]);
	    }
	    vertex_end(_buffer);
    
	    log("File Successfully Loaded : " + _name);
	    return _buffer;
	}
	else 
	{
	    error("File does not exist. : " + _name);
	    return noone;
	}




}
