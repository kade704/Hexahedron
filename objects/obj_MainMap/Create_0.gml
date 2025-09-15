/// @description 변수 초기화

///타일 생성
for(var i = 0; i < array_length(obj_MainSystem.NoteData) - 1; i++)
{
    
    if(i == 0) 
    {
        var tile = instance_create(0, 0, obj_TileBase);
		tile.Position = obj_MainSystem.Positions[i];
		tile.Rotation = obj_MainSystem.Rotations[i];
		tile.IsVisible = true;
		Tiles[i] = tile;
    }
    else if(i < obj_MainSystem.DataLength - 1 && (obj_MainSystem.NoteData[i].changeSpeed < obj_MainSystem.NoteData[i + 1].changeSpeed))
    {
        var tile = instance_create(0, 0, obj_TileSlow);
		tile.Position = obj_MainSystem.Positions[i];
		tile.Rotation = obj_MainSystem.Rotations[i];
		tile.IsVisible = false;
		Tiles[i] = tile;
    }
    else if(i < obj_MainSystem.DataLength - 1 && (obj_MainSystem.NoteData[i].changeSpeed > obj_MainSystem.NoteData[i + 1].changeSpeed))
    {
        var tile = instance_create(0, 0, obj_TileFast);
		tile.Position = obj_MainSystem.Positions[i];
		tile.Rotation = obj_MainSystem.Rotations[i];
		tile.IsVisible = false;
		Tiles[i] = tile;
    }
	else
	{
		var tile = instance_create(0, 0, obj_TileBase);
		tile.Position = obj_MainSystem.Positions[i];
		tile.Rotation = obj_MainSystem.Rotations[i];
		tile.IsVisible = false;
		Tiles[i] = tile;
	}
}


