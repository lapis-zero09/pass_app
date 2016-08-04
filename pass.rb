#! /usr/bin/ruby
require 'sqlite3'

def search
  print("Enter the service name for search: ")
  s = gets.chomp
  for_search(s)
end

def for_search(query, where="service")
  cursor = @db.execute("SELECT * FROM data WHERE #{where} = ?", query)
  if cursor.length == 0
    print("No such data\n")
  else
    show_data(cursor)
  end
end


def insert
  val = ""
  while val.include?("")
    val = for_insert
    if val == nil
      return nil
    end
    if val.include?("") == false
      print("name: #{val[0]}, id: #{val[1]}, pass: #{val[2]} -> ok ?(y/n/e)\n")
      s = gets.chomp
      if s == "y"
        break
      elsif s == "e"
        return nil
      else
        val = ""
      end
    end
  end
  cursor = @db.execute("INSERT INTO data VALUES(?, ?, ?)", [val[0], val[1], val[2]])
  for_search(val[0])
end

def for_insert
  print("↓Enter below 3 values for insert↓\n")
  print("Enter the service name for insert(or e): ")
  name = gets.chomp
  if name == "e"
    return nil
  end
  print("Enter the id for insert(or e): ")
  id = gets.chomp
  if id == "e"
    return nil
  end
  print("Enter the pass for insert(or e): ")
  pass = gets.chomp
  if pass == "e"
    return nil
  end
  return [name, id, pass]
end

def delete
  print("Enter the service name for delete(or e): ")
  s = gets.chomp
  if s == "e"
    return nil
  end
  cursor = @db.execute("DELETE FROM data WHERE service = ?", s)
end

def update
  bool = 0
  while bool == 0
    print("Enter the service name for update(or e): ")
    s = gets.chomp
    if s == "e"
      return nil
    end
    cursor = @db.execute("SELECT * FROM data WHERE service = ?", s)
    if cursor.length == 0
      print("No such data\n")
    else
      cursor.each do |d|
          print("#{d}\n")
          print("You need to change these values ?(y/n)")
          st = gets.chomp
          if st == "y"
            bool += 1
          end
      end
    end
  end

  change_num = ""
  while change_num != "1" && change_num != "2" && change_num != "3"
    print("Which value need you to change ?(name:1, id:2, pass:3 or e)")
    change_num = gets.chomp
    if change_num == "e"
      break
    end
  end

  if change_num == "e"
    return nil
  end

  print("change val(or e)?:")
  change_val = gets.chomp
  if change_num == "1"
    cursor = @db.execute("UPDATE data set name = ? WHERE service = ?", [change_val, s])
    for_search(change_val)
  elsif change_num == "2"
    cursor = @db.execute("UPDATE data set id = ? WHERE service = ?", [change_val, s])
    for_search(s)
  elsif change_num == "3"
    cursor = @db.execute("UPDATE data set pass = ? WHERE service = ?", [change_val, s])
    for_search(s)
  end

end

def show_data(cursor)
  cursor.each do |d|
      print("#{d}\n")
  end
end

# begin
  @db = SQLite3::Database.new("/opt/pass/info.db")

  point = @db.execute("SELECT * FROM user WHERE name = ?", "lapis")
  print("Enter the PASSWORD: ")
  password = gets.chomp
  point.each do |d|
    if password == d[1]
      print("e: exit, s: search, i: insert, d: delete, c: change\nEnter the value : ")
      while str = gets.chomp
        print("-----------------\n")
        if str == "e"
          break
        elsif str == "s"
          search
        elsif str == "i"
          insert
        elsif str == "d"
          delete
        elsif str == "c"
          update
        else
          puts "idiot?"
        end
        print("-----------------\n")
        print("e: exit, s: search, i: insert, d: delete, c: change\nEnter the value : ")
      end

    end
  end

  @db.close
# rescue => e
  # p e
# end
