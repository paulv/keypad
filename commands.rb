class Commands
  def initialize
    @onkyo_path = "#{ENV['HOME']}" + "/.local/bin/onkyo"
    @command_prefix = "#{@onkyo_path} --host 192.168.11.21 --port 60128 "
  end

  def switch_to_ps4
    exec_command("input-selector=dvd")
  end

  def switch_to_ps5
    exec_command("input-selector=video2")
  end

  def switch_to_pc
    exec_command("input-selector=strm-box")
  end

  def switch_to_switch
    exec_command("input-selector=game")
  end

  def toggle_mute
    exec_command("audio-muting=toggle")
  end

  def volume_up
    exec_command("master-volume=level-up")
  end

  def volume_down
    exec_command("master-volume=level-down")
  end

  def exec_command(command)
    full_command = @command_prefix + command
    pid = spawn(full_command, [:out, :err]=>"/dev/null")
    Process.detach pid
  end
end

# numlock
# backspace
# kpslash
# kpasterisk
# kpminus
# kpplus
# kpenter
# kpdot
# kp7
# kp8
# kp9
# kp4
# kp5
# kp6
# kp1
# kp2
# kp3
