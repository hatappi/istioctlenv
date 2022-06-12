function __fish_istioctlenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'istioctlenv' ]
    return 0
  end
  return 1
end

function __fish_istioctlenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c istioctlenv -n '__fish_istioctlenv_needs_command' -a '(istioctlenv commands)'
for cmd in (istioctlenv commands)
  complete -f -c istioctlenv -n "__fish_istioctlenv_using_command $cmd" -a "(istioctlenv completions $cmd)"
end
