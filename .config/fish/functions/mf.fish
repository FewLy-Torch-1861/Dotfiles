function mf
    # touch file with auto create dirs
    mkdir -pv (dirname "$argv[1]")
    touch "$argv[1]"
end
