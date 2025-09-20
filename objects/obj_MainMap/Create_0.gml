/// @description 변수 초기화

///타일 생성
for(var i = 0; i < array_length(obj_MainSystem.Positions); i++)
{
	var tile = noone;
    if(i > 0 && i < array_length(obj_MainSystem.Positions) - 1 && (obj_MainSystem.NoteData[i - 1].changeSpeed < obj_MainSystem.NoteData[i].changeSpeed))
    {
        tile = instance_create(0, 0, obj_TileSlow);
    }
    else if(i > 0 && i < array_length(obj_MainSystem.Positions) - 1 && (obj_MainSystem.NoteData[i - 1].changeSpeed > obj_MainSystem.NoteData[i].changeSpeed))
    {
        tile = instance_create(0, 0, obj_TileFast);
    }
	else
	{
		tile = instance_create(0, 0, obj_TileBase);
	}
	tile.Position = obj_MainSystem.Positions[i];
	tile.Rotation = obj_MainSystem.Rotations[i];
	tile.IsVisible = false;
	Tiles[i] = tile;
}


