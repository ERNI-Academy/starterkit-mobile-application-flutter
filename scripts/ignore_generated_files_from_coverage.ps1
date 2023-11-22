$filesToIgnore = @("*.gen.dart", "*.config.dart", "*.g.dart", "*.gr.dart", "*.reflectable.dart", "*.auto_mappr.dart", "messages_*.dart", "l10n.dart")

foreach ($filePattern in $filesToIgnore) {
    Get-ChildItem -Recurse -Filter $filePattern | ForEach-Object {
        $content = Get-Content $_.FullName -Raw
        $ignoreLine = "// coverage:ignore-file`r`n"
        $content = $ignoreLine + $content
        $content | Set-Content $_.FullName
    }
}