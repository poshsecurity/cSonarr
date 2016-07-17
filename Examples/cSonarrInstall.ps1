configuration DownloadHostDSC
{
    Import-DscResource -ModuleName 'cSonarr'

    cSonarrInstall SonarrInstaller
    {
        Ensure    = 'Present'
    }
}
