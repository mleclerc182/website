class Milo
  def self.getpic
    files = Dir.entries("app/assets/images/Milo")
    files.shift(2)
    files.sample
  end
end
