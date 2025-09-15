Alpha -= FadeOutSpeed;   

if(0 < Alpha)
{
    alarm[0] = 1;
}
else
{
    instance_destroy();
}

