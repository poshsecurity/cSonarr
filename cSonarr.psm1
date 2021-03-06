enum Ensure
{
    Absent
    Present
}

[DscResource()]
class cSonarrInstall 
{
    [DscProperty(Key)]
    [string] $Ensure
        
    # Gets the resource's current state.
    [cSonarrInstall] Get() 
    {
        $Package = Get-Package -Name 'Sonarr' -ErrorAction SilentlyContinue
        if ($null -ne $Package) 
        {
            $this.Ensure = [Ensure]::Present
        }
        else 
        {
            $this.Ensure = [Ensure]::Absent
        }
        return $this
    }
    
    # Sets the desired state of the resource.
    [void] Set() 
    {
        if ($this.Ensure -eq [Ensure]::Present)
        {
            # Download
            $DownloadURI = 'https://download.sonarr.tv/v2/master/latest/NzbDrone.master.exe'
            $DownloadDestination = Join-Path -Path $ENV:temp -ChildPath 'NzbDrone.master.exe'
            Invoke-WebRequest -Uri $DownloadURI -OutFile $DownloadDestination -UseBasicParsing

            $InstallPath = Join-Path -Path ${env:ProgramFiles} -ChildPath 'Sonarr'
            $ArgumentList = '/verysilent /norestart /DIR="{0}"' -f $InstallPath

            # Start install
            Start-Process -FilePath $DownloadDestination -ArgumentList $ArgumentList -Wait

            # Start service
            Start-Service 'NzbDrone'
        }
        else 
        {
            $SonarrInstall = Join-Path -Path ${env:ProgramFiles} -ChildPath 'Sonarr\bin'
            $SonarrUninstaller = Join-Path -Path $SonarrInstall -ChildPath 'unins000.exe'
            Start-Process -FilePath $SonarrUninstaller -ArgumentList '/verysilent /norestart' -Wait
        }
    }
    
    # Tests if the resource is in the desired state.
    [bool] Test() 
    {
        $Package = Get-Package -Name 'Sonarr' -ErrorAction SilentlyContinue
        
        if ($this.Ensure -eq [Ensure]::Present)
        {
            return ($null -ne $Package)
        }
        else 
        {
            # If it should be absent, check if null and return result
            return ($null -eq $Package) 
        }
    }
}
