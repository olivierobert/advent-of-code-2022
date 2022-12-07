def find_sum_directories(commands)
  directories = Hash.new

  commands.each_with_index do |command, index|
    previous_commands = commands.slice(0..(index - 1)).reverse
    file_regex = /(\d+)\s\S+/

    if (file_regex.match(command))
      cd_regex = /\$\scd\s(\S)/
      cd_command = previous_commands.find { |previous_command| cd_regex.match(previous_command) }
      directory_name = cd_regex.match(cd_command)[1]

      if directories[directory_name].nil?
        directories[directory_name] = []
      end

      directories[directory_name] << file_regex.match(command)[1]
    end
  end

  pp directories
end

content = File.readlines("input.txt").map { _1.gsub("\n", "") }

find_sum_directories(content)
