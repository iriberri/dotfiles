require 'fileutils'

DOTFILES = File.expand_path(File.dirname(__FILE__))
HOME = ENV["HOME"]

skip_all = false
overwrite_all = false

Dir.foreach(DOTFILES) do |file|
  next if ['.', '..', '.git', 'install.rb'].include? file

  overwrite = false
  backup = false

  source = File.join(DOTFILES, file)
  target = File.join(HOME, file)

  if File.exists?(target) || File.symlink?(target)
    unless skip_all || overwrite_all
      puts "File already exists: #{target}, what do you want to do?"
      puts "\t[s]kip, [S]kip all, [o]verwrite, [O]verwrite all"
      case STDIN.gets.chomp
      when 's' then next
      when 'o' then overwrite = true
      when 'O' then overwrite_all = true
      when 'S' then skip_all = true
      end
    end
    FileUtils.rm_rf(target) if overwrite || overwrite_all
  end
  `ln -s "#{source}" "#{target}"`
  puts "#{source} ==> #{target}"
end
