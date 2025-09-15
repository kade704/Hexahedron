/// @description 변수 초기화

TilesOpen = noone;
TileOpenCount = 0;
TileOpenTime = 0;
TileOpenRate = 6;

TilesClose = noone;
TileCloseCount = 0;
TileCloseTime = 0;
TileCloseRate = 3;

///타일 생성

MAP_SIZE_X = 10;
MAP_SIZE_Y = 7;

SongMap = array_create(MAP_SIZE_X);
for (var i = 0; i < MAP_SIZE_X; i++)
{
    SongMap[i] = array_create(MAP_SIZE_Y, -1);
	SongMap[i, 0] = -2;
	SongMap[i, MAP_SIZE_Y - 1] = -2;
}

SongMap[0, 0] = 0; // PN35A
SongMap[0, 6] = 1; // Ear of the Pig
SongMap[3, 0] = 999;
SongMap[3, 6] = 999;
SongMap[6, 0] = 999;
SongMap[6, 6] = 999;
SongMap[9, 0] = 999;
SongMap[9, 6] = 999;

for(var i = 0; i < MAP_SIZE_X; i++)
{
    for(var j = 0; j < MAP_SIZE_Y; j++)
    {
		if (SongMap[i, j] >= -1)
		{
			if (SongMap[i, j] >= 0) {
				var tile = instance_create(0, 0, obj_TileSong);
				tile.Position = vector3_create(i * 10, j * 10, 0);
				tile.IsVisible = true;
			} else {
				var tile = instance_create(0, 0, obj_TileBase);
				tile.Position = vector3_create(i * 10, j * 10, 0);
				tile.IsVisible = true;
			}
		}
    }
}

///타일 펼치는 순서를 기록

/*
TilesOpen[0, 0] = instance_position_3d(0, 0, 0, obj_Tile);
    
var count = 0;

do
{
    count = 0;
    
    for(var i = 0; i < array_length_2d(TilesOpen, TileOpenCount); i++)
    {
        var px = TilesOpen[TileOpenCount, i].PositionX;
        var py = TilesOpen[TileOpenCount, i].PositionY;
        var pz = TilesOpen[TileOpenCount, i].PositionZ;
    
        var tile = instance_position_3d(px + 10, py, pz, obj_Tile);
        if(tile != noone && !tile_exist(TilesOpen, tile))
        {
            tile.ForwardX = 1; tile.ForwardY = 0; tile.ForwardZ = 0;
            tile.RightX = 0; tile.RightY = 1; tile.RightZ = 0;
            tile.UpX = 0; tile.UpY = 0; tile.UpZ = 1; 
            
            TilesOpen[TileOpenCount + 1, count] = tile;
            count++;
        }
            
        var tile = instance_position_3d(px - 10, py, pz, obj_Tile);
        if(tile != noone && !tile_exist(TilesOpen, tile))
        {
            tile.ForwardX = -1; tile.ForwardY = 0; tile.ForwardZ = 0;
            tile.RightX = 0; tile.RightY = -1; tile.RightZ = 0;
            tile.UpX = 0; tile.UpY = 0; tile.UpZ = 1; 
            
            TilesOpen[TileOpenCount + 1, count] = tile;
            count++;
        }
            
        var tile = instance_position_3d(px, py + 10, pz, obj_Tile);
        if(tile != noone && !tile_exist(TilesOpen, tile))
        {
            tile.ForwardX = 0; tile.ForwardY = 1; tile.ForwardZ = 0;
            tile.RightX = -1; tile.RightY = 0; tile.RightZ = 0;
            tile.UpX = 0; tile.UpY = 0; tile.UpZ = 1; 
        
            TilesOpen[TileOpenCount + 1, count] = tile;
            count++;
        }
            
        var tile = instance_position_3d(px, py - 10, pz, obj_Tile);
        if(tile != noone && !tile_exist(TilesOpen, tile))
        {
            tile.ForwardX = 0; tile.ForwardY = -1; tile.ForwardZ = 0;
            tile.RightX = 1; tile.RightY = 0; tile.RightZ = 0;
            tile.UpX = 0; tile.UpY = 0; tile.UpZ = 1; 
        
            TilesOpen[TileOpenCount + 1, count] = tile;
            count++;
        }
    }      
    TileOpenCount++;
} until(count == 0);

alarm[0] = TileOpenRate;

*/