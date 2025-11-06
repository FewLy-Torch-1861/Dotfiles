function ext
    # auto detect file and extract it
    switch $argv[1]
        case '*.tar.gz' '*.tgz'
            tar -xvzf $argv[1]
        case '*.tar.bz2'
            tar -xvjf $argv[1]
        case '*.tar'
            tar -xvf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.gz'
            gunzip $argv[1]
        case '*.bz2'
            bunzip2 $argv[1]
        case '*'
            echo "Unknown archive: $argv[1]"
    end
end
