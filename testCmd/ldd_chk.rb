#!/usr/bin/ruby
# coding: utf-8

#
#   コンパイル結果のバイナリーをチェック
#

target = {
  "/usr/local/bin/b25"         => :type2,
  "/usr/local/bin/epgdump"     => :type1,
  "/usr/local/bin/recdvb"      => :type2,
  "/usr/local/bin/recpt1"      => :type2,
  "/usr/local/bin/tspacketchk" => :type1,
}


def chk_lib()
  list = []
  if ( arib = ENV["ARIBLIB"] ) == nil
    raise "Error: 環境変数 ARIBLIB が設定されていません。"
  else
    list << case arib
            when "libarib25"  then arib
            when "libaribb25" then arib
            else
              raise "Error: 環境変数 ARIBLIB の値が不正です。"
            end
  end

  if ( sc = ENV["USE_YAKISOBA"] ) == nil
    raise "Error: 環境変数 USE_YAKISOBA が設定されていません。"
  else
    if sc == "yes"
      list += [ "libyakisoba","libsobacas" ]
    elsif sc == "no"
      list << "libpcsclite"
    else
      raise "Error: 環境変数 USE_YAKISOBA の値が不正です。"
    end
  end

  printf("%16s = %s\n","ARIBLIB",arib )
  printf("%16s = %s\n","USE_YAKISOBA", sc )
  printf("%16s = %s\n","chk lib", list.join(",") )
  
  return list
end

#
#  リンク先のチェック
#
def ldd_chk( path, list )
  chkList = {}
  list.each do |key| chkList[ key ] = false end
  `ldd #{path}`.each_line do |l|
    tmp = l.strip
    chkList.keys.each do |key|
      if tmp =~ /#{key}/
        chkList[ key ] = true
      end
    end
  end
  result = []
  chkList.each_pair do |key,val|
    if val == false
      result << key
    end
  end
  if result.size == 0
    return nil
  else
    return "(not found " + result.join(",") + ")"
  end
end

#
#  ファイルの存在チェック
#
def file_chk( path )
  unless test( ?x, path )
    return "( file not found )"
  end
  return nil
end


lib_list = chk_lib()

target.each_pair do |path,type|
  r = nil
  if type == :type1
    r = file_chk( path )
  end
  if type == :type2
    r = ldd_chk( path, lib_list )
  end
  r2 = r == nil ? "OK" : "NG" 
  printf("%-30s  %s %s\n",path, r2, r == nil ? "" : r )
end

