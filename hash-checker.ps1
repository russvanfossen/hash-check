# Load necessary .NET Framework classes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName Microsoft.VisualBasic

$Global:hashType = $null

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'Hash Checker'
$main_form.AutoSize = $true

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Hash Type"
$Label.Location = New-Object System.Drawing.Point(10,10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$hashTypeComboBox = New-Object System.Windows.Forms.ComboBox
$hashTypeComboBox.Items.AddRange(@('MD5', 'SHA1', 'SHA256', 'SHA512'))
$hashTypeComboBox.Location = New-Object System.Drawing.Point(10, 30)
$hashTypeComboBox.Size = New-Object System.Drawing.Size(100, 20)
$main_form.Controls.Add($hashTypeComboBox)

$hashTypeComboBox.add_SelectedIndexChanged({
    $Global:hashType = $hashTypeComboBox.SelectedItem
    $main_form.Close()
    })

$main_form.ShowDialog()

$givenHashbox = [Microsoft.VisualBasic.Interaction]::InputBox('Enter the hash:', 'Hash Input', '', 0, 0)
$givenHash = $givenHashbox.ToUpper()
Write-Host $givenHash
if ( $givenHash -eq "") { exit }

Write-Host $Global:hashType

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.Multiselect = $false
$response = $OpenFileDialog.ShowDialog( )
$chosenFile = $OpenFileDialog.FileName
if ( $response -eq 'OK' ) { Write-Host $chosenFile }


Write-Host 'Computing Hash'
$computedHash = Get-FileHash -Path $chosenFile -Algorithm $Global:hashType | Select-Object -ExpandProperty Hash

Write-Host $computedHash

Write-Host 'Comparing Hashes'

if ($computedHash -eq $givenHash) {
            [System.Windows.Forms.MessageBox]::Show('Hash verification successful!', 'Success', 'OK','Information')
        } else {
            [System.Windows.Forms.MessageBox]::Show('Hash verification failed!', 'Warning', 'OK', 'Stop')
        }
