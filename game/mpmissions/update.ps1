# Update the working directory and report the revision each mission and its external pra3 directory are at.

svn update

Get-ChildItem | Where {$_.PSIsContainer} | foreach {
	$missionRev = svn info --xml $_.FullName;
	if ($?)
	{
		$missionRev = ([xml]$missionRev).info.entry.commit.revision;

		$coreRev = svn info --xml ($_.FullName + "\pra3");
		if ($?)
		{
			$coreRev = ([xml]$coreRev).info.entry.commit.revision;

			echo ($_.Name + " Mission revision: " + $missionRev + " Core revision: " + $coreRev);
			
			echo $missionRev > ($_.FullName + "\revision.txt");
			echo $coreRev > ($_.FullName + "\pra3\revision.txt");
		}
	}
}
