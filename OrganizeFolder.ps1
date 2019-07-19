
# this Script will organize any folder Provided by a user by creating and moving the data into folders  for days XXXX_XX_XX(year_month_day). To be run once per day
#

param([string] $dir = "<Put your folder here>")



function checkLocation($dir) 
{
    # listing files
    $files_listed = Get-ChildItem -Path $($dir)
    for ($i=0; $i -lt $files_listed.length; $i++) 
    {
         if($files_listed[$i] -notmatch "\d{4}_\d{1,2}_\d{1,2}")
         {
            write-host("File Found ==> $($files_listed[$i])")
            CreateNewFolder $dir
            exit
         }
    }
    write-host(" NO File Found ")
}



function CreateNewFolder($parent_PAth)
    {
        $timeVar = Get-Date -UFormat "%Y_%m_%d"
        $New_DirPath = -join($($parent_PAth),'\', $($timeVar))
        #create a Folder with title 'year_month_day to move everything in
        if (-not (Test-Path $New_DirPath)) 
        {
            New-Item -Path $($New_DirPath) -ItemType Directory
        }else 
        {
            Write-Output "Directory Exists Already"
        }
        MoveFiles $parent_PAth $New_DirPath
    }


function MoveFiles($parentPAth, $NewDirPath)
    {
       
       $files_listed = Get-ChildItem -Path $($parentPAth)
       for ($i=0; $i -lt $files_listed.length; $i++)
        {
             if($files_listed[$i] -notmatch "\d{4}_\d{1,2}_\d{1,2}")
             {
                $SrcPath= -join($($parentPAth),'\', $($files_listed[$i]))
                write-host("Moving $($SrcPath)  ==>  $($NewDirPath)")        
                Move-Item $SrcPath -Destination $NewDirPath 
             }

        }

    }





checkLocation $dir