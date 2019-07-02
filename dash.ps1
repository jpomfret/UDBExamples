Import-Module UniversalDashboard.Community

$Dashboard = New-UDDashboard -Title "Processes" -Content {
    New-UDLayout -Columns 2 -Content {
        New-UDTextbox -Placeholder 'Process Name' -Id 'txtprocess'
        New-UDButton -Id 'btnSearch' -Text 'Search' -OnClick {
            $Session:Process = (Get-UDElement -Id 'txtprocess').Attributes['value']
            #Sync-UDElement -Id 'chart'
            Sync-UDElement -Id 'grid'
        }
    }

    New-UDRow -Columns {
        #New-UDColumn -SmallSize 6 -Content {
        #    New-UDChart -Type Line -Id 'chart' -Title "Stock Price Chart" -Endpoint {
        #        if ($Session:Ticker -eq $null) {
        #            $Session:Ticker = "MSFT"
        #        }
#
        #        invoke-restmethod https://api.iextrading.com/1.0/stock/$Session:Ticker/chart | Out-UDChartData -DataProperty close -LabelProperty date
        #    }
        #}

        New-UDColumn -SmallSize 6 -Content {
            New-UDGrid -Id 'grid' -Title "Get Process" -Headers @("ProcessName", "id", "CPU") -Properties @("ProcessName", "Id", "CPU") -Endpoint {
                if ($Session:Process -eq $null) {
                    $Session:Process = "Chrome"
                }
                Get-Process -Name $Session:Process | Out-UDGridData
            }
        }
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 10000 -AutoReload

## code based on https://poshtools.com/2018/11/13/dynamically-updating-controls-with-sync-udelement/