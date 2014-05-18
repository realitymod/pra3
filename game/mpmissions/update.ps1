# Update the working directory and report the revision each mission and its external pra3 directory are at.

echo "Updating working copy...";

svn update

echo "Fetching and writing SVN revisions for each mission...";
echo "";

Get-ChildItem | Where {$_.PSIsContainer} | foreach {
	echo ($_.Name);

	# First make sure the mission dir is versioned
	svn info $_.FullName > $null 2>&1;

	if ($?)
	{
		$missionRev = svn info --xml $_.FullName;
		$missionRev = ([xml]$missionRev).info.entry.commit.revision;

		$coreRev = svn info --xml ($_.FullName + "\pra3");
		if ($?)
		{
			$coreRev = ([xml]$coreRev).info.entry.commit.revision;

			echo (" > Mission revision: " + $missionRev);
			echo (" > Core revision: " + $coreRev);

			echo $missionRev > ($_.FullName + "\revision.txt");
			echo $coreRev > ($_.FullName + "\pra3\revision.txt");
		}
	}
	else
	{
		echo " > Not versioned, skipping";
	}

	echo "";
}

echo "DONE!";
