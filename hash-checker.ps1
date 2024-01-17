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



# $Label2 = New-Object System.Windows.Forms.Label
# $Label2.Text = "Given Hash"
# $Label2.Location = New-Object System.Drawing.Point(10,70)
# $Label2.AutoSize = $true
# $main_form.Controls.Add($Label2)

# $givenHash = New-Object System.Windows.Forms.TextBox
# $givenHash.Location = New-Object System.Drawing.Point(10,90)
# $givenHash.Size = New-Object System.Drawing.Size(500, 20)
# $main_form.Controls.Add($givenHash)

# $initialDirectory = [Environment]::GetFolderPath('Desktop')
# $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
# $OpenFileDialog.InitialDirectory = $initialDirectory
# $OpenFileDialog.Multiselect = $false

# $FileButton = New-Object System.Windows.Forms.Button
# $FileButton.Location = New-Object System.Drawing.Size(10,150)
# $FileButton.Size = New-Object System.Drawing.Size(120,23)
# $FileButton.Text = "Choose File"
# $main_form.Controls.Add($FileButton)

# $GoButton = New-Object System.Windows.Forms.Button
# $GoButton.Location = New-Object System.Drawing.Size(10,200)
# $GoButton.Size = New-Object System.Drawing.Size(120,23)
# $GoButton.Text = "Compare Hash"
# $main_form.Controls.Add($GoButton)


# $FileButton.Add_Click(
# {
# $response = $OpenFileDialog.ShowDialog( ) # $response can return OK or Cancel
# if ( $response -eq 'OK' ) { Write-Host 'You selected the file:' $OpenFileDialog.FileName }
# }
# )





# # Create a form for selecting hash type
# $form = New-Object System.Windows.Forms.Form
# $form.Text = 'Select Hash Type'
# $form.Size = New-Object System.Drawing.Size(300, 200)
# $form.StartPosition = 'CenterScreen'

# # Create a dropdown list
# $hashTypeComboBox = New-Object System.Windows.Forms.ComboBox
# $hashTypeComboBox.Location = New-Object System.Drawing.Point(10, 40)
# $hashTypeComboBox.Size = New-Object System.Drawing.Size(260, 20)
# $hashTypeComboBox.Items.AddRange(@('MD5', 'SHA1', 'SHA256', 'SHA512'))
# $form.Controls.Add($hashTypeComboBox)

# # Create a label
# $label = New-Object System.Windows.Forms.Label
# $label.Location = New-Object System.Drawing.Point(10, 20)
# $label.Size = New-Object System.Drawing.Size(280, 20)
# $label.Text = 'Please select a hash type:'
# $form.Controls.Add($label)

# # Show the form and save selected hash type
# $result = $form.ShowDialog()
# if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
#     $hashtype = $hashTypeComboBox.SelectedItem
# }

# # Create an input box for entering hash
# $hashInputBox = [Microsoft.VisualBasic.Interaction]::InputBox('Enter the hash:', 'Hash Input', '', 0, 0)

# # Open file picker dialog
# $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
# $fileDialog.Filter = 'All Files (*.*)|*.*'
# $fileDialog.Title = 'Select a file'
# if ($fileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
#     $chosenFile = $fileDialog.FileName
#     # Calculate hash of the chosen file
#     $computedHash = Get-FileHash -Path $chosenFile -Algorithm $hashtype | Select-Object -ExpandProperty Hash
#     if ($computedHash -eq $hashInputBox) {
#         [System.Windows.Forms.MessageBox]::Show('Hash verification successful!', 'Success', 'Information')
#     } else {
#         [System.Windows.Forms.MessageBox]::Show('Hash verification failed!', 'Warning', 'Warning')
#     }
# }
