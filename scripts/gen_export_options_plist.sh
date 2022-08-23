export Secrets=$(cat .secrets/$1.secrets)

iOSExportMethod=$(echo $Secrets | jq -r '.iOSExportMethod')
iOSDevelopmentTeam=$(echo $Secrets | jq -r '.iOSDevelopmentTeam')
iOSDistributionProfile=$(echo $Secrets | jq -r '.iOSDistributionProfile')
appId=$(echo $Secrets | jq -r '.appId')
appIdSuffix=$(echo $Secrets | jq -r '.appIdSuffix')

rm ios/Runner/ExportOptions.plist

echo "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+CjxwbGlzdCB2ZXJzaW9uPSIxLjAiPgo8ZGljdD4KCTxrZXk+Y29tcGlsZUJpdGNvZGU8L2tleT4KCTx0cnVlLz4KCTxrZXk+bWV0aG9kPC9rZXk+Cgk8c3RyaW5nPjwvc3RyaW5nPgoJPGtleT5wcm92aXNpb25pbmdQcm9maWxlczwva2V5PgoJPGRpY3Q+Cgk8L2RpY3Q+Cgk8a2V5PnNpZ25pbmdDZXJ0aWZpY2F0ZTwva2V5PgoJPHN0cmluZz5pT1MgRGlzdHJpYnV0aW9uPC9zdHJpbmc+Cgk8a2V5PnNpZ25pbmdTdHlsZTwva2V5PgoJPHN0cmluZz5tYW51YWw8L3N0cmluZz4KCTxrZXk+dGVhbUlEPC9rZXk+Cgk8c3RyaW5nPjwvc3RyaW5nPgoJPGtleT51cGxvYWRCaXRjb2RlPC9rZXk+Cgk8dHJ1ZS8+Cgk8a2V5PnVwbG9hZFN5bWJvbHM8L2tleT4KCTx0cnVlLz4KPC9kaWN0Pgo8L3BsaXN0Pg==" | base64 --decode > ios/Runner/ExportOptions.plist

/usr/libexec/PlistBuddy -c "Set :method ${iOSExportMethod}" ios/Runner/ExportOptions.plist
/usr/libexec/PlistBuddy -c "Set :teamID ${iOSDevelopmentTeam}" ios/Runner/ExportOptions.plist
/usr/libexec/PlistBuddy -c "Add :provisioningProfiles:${appId}${appIdSuffix} string ${iOSDistributionProfile}" ios/Runner/ExportOptions.plist
