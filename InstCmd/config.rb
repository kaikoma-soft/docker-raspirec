#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

#
#  http port
#
Http_port  = 4567

#
#  ディレクトリ、ファイル関係
#
Recpt1_cmd = "/usr/local/bin/recpt1"
Recpt1_opt =  %w( --b25 ) 
Epgdump    = "/usr/local/bin/epgdump"

BaseDir = "/usr/local/raspirec" 
SrcDir  = BaseDir + "/src"

DataDir = "/raspirec"
TSDir   = DataDir + "/ts" 
DBDir   = DataDir + "/db"


#
# 録画タイミング関係
#
Start_margin  = 10              # 録画開始前マージン(秒)
After_margin  = 3               # 録画終了後マージン(秒)
Gap_time      = 5               # 録画終了-次番組開始間隔(秒)

#
#  チューナー関係
#
GR_tuner_num      = 2           # 地デジチュナー数
BSCS_tuner_num    = 2           # BSCSチュナー数
Total_tuner_limit = 4           # トータルチュナー数制限

#
#  EPG関係
#
GR_EPG_channel = %w( 13 14 15 16 17 18 26 27 28 31 )
BS_EPG_channel = %w( BS15_0 )                     # BS EPG 受信局
CS_EPG_channel = %w( CS4 CS2 )                    # CS EPG 受信局
GR_EpgRsvTime  = 60                               # EPG受信時間 (秒)
BS_EpgRsvTime  = 300                              # EPG受信時間 (秒)
CS_EpgRsvTime  = 300                              # EPG受信時間 (秒)
EPGperiod      = 8                                # EPG 取得周期 (H)
#EpgBanTime     = [ 2, 3, 4, 5 ]                   # EPG禁止時間帯(24H制)

#
#   ダイアログのオプション初期値 ( true でチェック付き )
#
D_FreeOnly = false              # 無料放送のみ
D_dedupe   = false              # 重複予約は無効化する
D_jitan    = true               # チューナー不足の場合に時短を許可


#
#   TSファイル scp 転送
#
TSFT =  false 
TSFT_host  = "XXXXX"            # 宛先ホスト名
TSFT_user  = "YYYYY"            # login名
TSFT_toDir = "/data/spool"      # 送り先Dir
TSFT_rate  = 15                 # 想定転送速度 ( Mbyte/秒 )


#
#   HLS モニタ機能
#
MonitorFunc =  false 
MonitorWidth = 720                                # モニタ画面の横幅
HlsConvCmd   = SrcDir  + "/tool/ts2hls_sample.sh" # HLS変換コマンド
StreamDir    = DataDir + "/stream"                # ストリーム出力先ディレクトリ

#
#   media player モニタ機能
#
MPMonitor       = false                              # mpv モニタ機能を有効に
DeviceList_GR =  %w( /dev/pt1video2 /dev/pt1video3 ) 
DeviceList_BSCS =  %w( /dev/pt1video0 /dev/pt1video1 ) 
MPlayer_cmd     = %w( mpv --deinterlace=yes --autofit=720x405 --quiet )

RemoteMonitor =  false 
UDPbasePort     = 12345         # UDP port 
XServerName     = "desktop"     # mpv を実行するマシン名
RecHostName     = "raspi"       # raspirec,recpt1 を実行するマシン名
Lsof_cmd        = "/usr/bin/lsof"



#
#   その他
#
LogSaveDay =  7 
RsvHisSaveDay  = 180       # 録画済み記録の保持期間(日)
DiskKeepPercent =  false 
Local_jquery    = false    # jquery等をローカルに用意した場合に true
StationPage     = 7        # 番組表で、1ページ当たりの放送局数 (個)
TSnameFormat =  "%YEAR%-%MONTH%-%DAY%_%HOUR%:%MIN%_%DURATION%_%TITLE%_%CHNAME%" 

TitleRegex = [        # 題名の削除フィルター
    /【N】/,
    /【SS】/,
    /【デ】/,
    /【再】/,
    /【双】/,
    /【多】/,
    /【天】/,
    /【字】/,
    /【新】/,
    /【無】/,
    /【解】/,
    /【終】/,
    /【初】/,
  ]

SearchStringRegex = [        # 検索文字列の削除フィルター 
  /\#\d+\s?[・-]\s?\#\d+/,
  /[\#♯＃][１２３４５６７８９０\d]+/,
  /第[一二三四五六七八九十１２３４５６７８９０\d]+話/,
  /「.*」/,
] + TitleRegex

#
#   以下は必要がなければ変更不要
#

DbFname      = DBDir + "/epg.db"
EPGLockFN    = DBDir + "/epg.lock"
MainLockFN   = DBDir + "/main.lock"
DbupdateFN   = DBDir + "/db.update"

LogDir       = DataDir + '/log'
JsonDir      = DataDir + '/json'
PidFile      = LogDir + '/raspirec.pid'
TimerPidFile = LogDir + '/timer.pid'
HttpdPidFile = LogDir + '/httpd.pid'
ConfDir      = BaseDir + '/Conf.d'

LogFname     = LogDir + '/raspirec.log'
StdoutM      = LogDir + "/main_out.log"  # main debug 標準出力ファイル
StderrM      = LogDir + "/main_err.log"  # main debug 標準エラーファイル
StdoutH      = LogDir + "/httpd_out.log" # httpd debug 標準出力ファイル
StderrH      = LogDir + "/httpd_err.log" # httpd debug 標準エラーファイル
StdoutT      = LogDir + "/timer_out.log" # timer debug 標準出力ファイル
StderrT      = LogDir + "/timer_err.log" # timer debug 標準エラーファイル

EpgRsvTime = [ GR_EpgRsvTime, BS_EpgRsvTime, CS_EpgRsvTime ].max * 1.5

Debug =  true 
Debug_mem  = false              # メモリの消費量の表示


