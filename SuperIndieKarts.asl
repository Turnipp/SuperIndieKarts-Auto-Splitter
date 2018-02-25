state("SuperIndieKarts")
{
  //float time : 0x01084B78, 0x0, 0x8, 0x70, 0x14, 0x4c; /* in-game timer */
}

init
{
  //pointer to lap count
  vars.lap_ptr = new DeepPointer("mono.dll", 0x001f4648, 0x400, 0x4e8, 0x28, 0xb8);
  //get lap currently stored in lap pointer
  vars.lap = vars.lap_ptr.Deref<byte>(game);
  //last lap recorded
  vars.llap = vars.lap;
}

startup
{
  settings.Add("lap", false, "split every lap");
  settings.Add("50cc", false, "50cc races");
  settings.Add("100cc", false, "100cc races");
  settings.Add("150cc", true, "150cc races");
}

update
{
	vars.llap = vars.lap;
	//get lap currently stored in lap pointer
	vars.lap = vars.lap_ptr.Deref<byte>(game);
}

split
{
	//check is lap was incremented
	if (vars.llap < vars.lap)
	{
		//lap counter is set to zero until the player first crosses the start line
		if (vars.llap == 0)
		{
			return false;
		}
		
		if (settings["lap"])
		{
			return true;
		}
		else if (vars.lap == 4 && settings["50cc"])
		{
			return true;
		}
		else if (vars.lap == 5 && settings["100cc"])
		{
			return true;
		}
		else if (vars.lap == 6 && settings["150cc"])
		{
			return true;
		}
	}
}
