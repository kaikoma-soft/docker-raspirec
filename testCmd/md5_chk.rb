#!/usr/bin/ruby
# coding: utf-8

#
#   ソースの zip ファイルの md5 チェックサムを確認
#
require 'digest/md5'

target = {
  "epgdump-master.zip"    => "79db64df336b80d90244e2c5ee2e2531",
  "libarib25-master.zip"  => "9102c6c34b8778cd928900d6f88a1ba3",
  "libaribb25-master.zip" => "40bfccdd3c0830d08dc0533a6b90373b",
  "libsobacas.zip"        => "4c86162fb440aa41fb8eda195d1ce06b",
  "libyakisoba.zip"       => "cd5d0b02c76c9baa2f3528e790e11849",
  "raspirec-master.zip"   => "698acbd13e4d422c46704237009ca684",
  "recdvb-master.zip"     => "4bf81e45b4b268cb6e93da999ac096de",
  "recpt1-master.zip"     => "fcdfad67bdc336af3fce0d904c9640a6",
  "tspacketchk-main.zip"  => "0e4d919fcb65ceba20a1fac3ccaa3bdd",
}

puts( ">>>> md5 check <<<<" )
err = 0
target.each_pair do |f,v|
  path = "Download/" + f

  if test( ?f, path )
    md5 = Digest::MD5.file( path ).to_s

    if v == nil
      printf("  \"%s\" => \"%s\",\n",f,md5 )
    else
      if v == md5 
        printf("%-24s  Ok\n", f )
      else
        printf("%-24s  diff \(%s %s\)\n", f, v, md5 )
        err += 1
      end
    end
  else
    printf("%-24s  NG (file not found)\n",f)
    err += 1
  end
end

exit err

