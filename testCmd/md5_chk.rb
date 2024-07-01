#!/usr/bin/ruby
# coding: utf-8

#
#   ソースの zip ファイルの md5 チェックサムを確認
#
require 'digest/md5'

target = {
#  "epgdump-master.zip"    => "a02cd891e980e31341fce79d31e81831",
  "epgdump-master.zip"    => "79db64df336b80d90244e2c5ee2e2531",
  "libarib25-master.zip"  => "9102c6c34b8778cd928900d6f88a1ba3",
#  "libaribb25-master.zip" => "b17b1bdef82ef3420111972dd25bc9e8",
  "libaribb25-master.zip" => "baa0de3c9c564de668ee7ca03ddaf198",
  "libsobacas.zip"        => "4c86162fb440aa41fb8eda195d1ce06b",
  "libyakisoba.zip"       => "cd5d0b02c76c9baa2f3528e790e11849",
#  "raspirec-master.zip"   => "09309229ac388a5552f44cf51c6e90b2",
#  "raspirec-master.zip"   => "59f6a952257312967f24d72b44bcb1a0",
  "raspirec-master.zip"   => "0d42c35777c26582ff49035969845516",
#  "recdvb-master.zip"     => "c776b532f99c829f53b7e64f351123be",
  "recdvb-master.zip"     => "ec64c622389139d4a8f89543c7a2d124",
#  "recpt1-master.zip"     => "4dcd0ff1b244eaa1e8d2a61f5206cc8d",
#  "recpt1-master.zip"     => "c359157e3a09bea9b2179abe55866f79",
  "recpt1-master.zip"     => "d1dc002fee20db95987ecf7399d0f131",
#  "tspacketchk-main.zip"  => "ad70079ae15640fb1acbd459987fb6eb",
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

