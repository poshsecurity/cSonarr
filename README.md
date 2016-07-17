#cSonarr

A simple DSC module for maintaining a Sonarr (formally NZB Drone) install

## Resources

* **SonarrInstall** controls installation of Sonarr

### SonarrInstall

Controls the installation (absent or present) of Sonarr, also ensure that the software is automatically updated.

* **Ensure**: Ensure either Absent or Present (Installed and Updated)

## Versions

### Unreleased

* 1.4 has not been released to PS Gallery

### 1.4

* Work to ensure that the DSC module meets community guidelines and DSC guidelines
* Developing test cases

## Examples
### Ensure Sonarr Installed

```powershell
configuration DownloadHostDSC
{
    Import-DscResource -ModuleName 'cSonarr'

    cSonarrInstall SonarrInstaller
    {
        Ensure    = 'Present'
    }
}
```

Ensures that Sonarr is installed.

### Ensure Sonarr not installed

```powershell
configuration DownloadHostDSC
{
    Import-DscResource -ModuleName 'cSonarr'

    cSonarrInstall SonarrInstaller
    {
        Ensure    = 'Absent'
    }
}
```

Ensures that Sonarr is not installed.
