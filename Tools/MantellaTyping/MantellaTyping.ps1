param([string]$Test)

$file = 'D:\SteamLibrary\steamapps\common\SkyrimVR\Data\MantellaTyping\input.txt'

function Save-Message([string]$text) {
    $clean = ($text -replace '[\r\n\t]+', ' ').Trim()
    [IO.File]::WriteAllText($file, $clean, (New-Object Text.UTF8Encoding($false)))
    return $clean
}

if ($PSBoundParameters.ContainsKey('Test')) {
    Save-Message $Test | Out-Null
    return
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = 'Mantella Typing'
$form.Size = New-Object Drawing.Size(620, 170)
$form.TopMost = $true
$form.StartPosition = 'CenterScreen'

$box = New-Object Windows.Forms.TextBox
$box.Location = New-Object Drawing.Point(12, 12)
$box.Size = New-Object Drawing.Size(580, 32)
$box.Font = New-Object Drawing.Font('Segoe UI', 13)
$box.Anchor = 'Top,Left,Right'

$status = New-Object Windows.Forms.Label
$status.Location = New-Object Drawing.Point(12, 58)
$status.Size = New-Object Drawing.Size(580, 60)
$status.Font = New-Object Drawing.Font('Segoe UI', 10)
$status.Anchor = 'Top,Left,Right'
$status.Text = 'Type here and press Enter, then press the Mantella text hotkey in game.'

$box.Add_KeyDown({
    param($s, $e)
    if ($e.KeyCode -eq 'Return') {
        $e.SuppressKeyPress = $true
        $msg = Save-Message $box.Text
        if ($msg) {
            $status.Text = "Ready: $msg`nNow press the Mantella text hotkey in game."
            $box.Clear()
        }
    }
})

$form.Controls.Add($box)
$form.Controls.Add($status)
$form.Add_Shown({ $box.Focus() })
[Windows.Forms.Application]::Run($form)
