#!/usr/bin/ruby
# coding: utf-8

#
#   ソースの zip ファイルの md5 チェックサムを確認
#
require 'digest/md5'

target = {
  "epgdump-master.zip"    => "a02cd891e980e31341fce79d31e81831",
  "libarib25-master.zip"  => "9102c6c34b8778cd928900d6f88a1ba3",
  "libaribb25-master.zip" => "b17b1bdef82ef3420111972dd25bc9e8",
  "libsobacas.zip"        => "4c86162fb440aa41fb8eda195d1ce06b",
  "libyakisoba.zip"       => "cd5d0b02c76c9baa2f3528e790e11849",
  "raspirec-master.zip"   => "09309229ac388a5552f44cf51c6e90b2",
  "recdvb-master.zip"     => "c776b532f99c829f53b7e64f351123be",
  "recpt1-master.zip"     => "4dcd0ff1b244eaa1e8d2a61f5206cc8d",
  "tspacketchk-main.zip"  => "ad70079ae15640fb1acbd459987fb6eb",
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

