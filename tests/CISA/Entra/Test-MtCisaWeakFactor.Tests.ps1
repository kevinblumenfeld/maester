BeforeDiscovery {
    $EntraIDPlan = Get-MtLicenseInformation -Product EntraID
}

Describe "CISA SCuBA" -Tag "MS.AAD", "MS.AAD.3.5", "CISA", "Security", "All" -Skip:( $EntraIDPlan -eq "Free" ) {
    It "MS.AAD.3.5: The authentication methods SMS, Voice Call, and Email One-Time Passcode (OTP) SHALL be disabled." {

        $isMethodsMigrationComplete = Test-MtCisaMethodsMigration

        $isWeakFactorDisabled = Test-MtCisaWeakFactor

        $isWeakFactorDisabled -and $isMethodsMigrationComplete | Should -Be $true -Because "all weak authentication methods are disabled."
    }
}