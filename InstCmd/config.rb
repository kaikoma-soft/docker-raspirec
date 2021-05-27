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
GBC_tuner_num     = 0           # 地デジ/BS/CS チューナー数
Total_tuner_limit = false       # トータルチュナー数制限

#
#  EPG関係
#
GR_EPG_channel = %w(  )                           # 地デジ受信局
BS_EPG_channel = %w( BS15_0 )                     # BS EPG 受信局
CS_EPG_channel = %w( CS4 CS2 )                    # CS EPG 受信局
GR_EpgRsvTime  = 50                               # EPG受信時間 (秒)
BS_EpgRsvTime  = 150                              # EPG受信時間 (秒)
CS_EpgRsvTime  = 200                              # EPG受信時間 (秒)
EPGperiod      = 6                                # EPG 取得周期 (H)
EpgBanTime     = [ 2, 3, 4, 5 ]                   # EPG禁止時間帯(24H制)

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
MPMonitor       = false         # mpv モニタ機能を有効に
DevAutoDetection = true         # デバイスファイルの自動検出 true = 有効 
DeviceList_GR   = []            # 地デジ チューナー デバイスファイル 
DeviceList_BSCS = []            # BS/CS                  〃
DeviceList_GBC  = []            # 三波共用(地デジ/BS/CS) 〃
MPlayer_cmd     = %w( mpv --deinterlace=yes --autofit=720x405 --quiet )

RemoteMonitor =  false 
UDPbasePort     = 12345         # UDP port 
XServerName     = "desktop"     # mpv を実行するマシン名
RecHostName     = "raspi"       # raspirec,recpt1 を実行するマシン名
Lsof_cmd        = "/usr/bin/lsof"

#
#   パケットチェック機能
#
PacketChk_enable     = true                         # true = 有効にする
PacketChk_cmd        = "/usr/local/bin/tspacketchk" # 
PacketChk_opt        = "-s 1 "                      # オプション
PacketChk_threshold  = 2                            # エラーと判定する閾値
PacketChk_rate       = 20                           # 想定速度 ( Mbyte/秒 )


#
#   その他
#
LogSaveDay =  7 
RsvHisSaveDay  = 180       # 録画済み記録の保持期間(日)
DiskKeepPercent =  false 
Local_jquery    = false    # jquery等をローカルに用意した場合に true
StationPage     = 7        # 番組表で、1ページ当たりの放送局数 (個)
TSnameFormat =  "%YEAR%-%MONTH%-%DAY%_%HOUR%:%MIN%_%DURATION%_%TITLE%_%CHNAME%" 
EpgPatchEnable  = true     # EPGPatch機能の制御。デフォルトで有効。false = 無効 

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
DeviceChkFN  = DBDir + "/devicechk.yaml"

LogDir       = DataDir + '/log'
JsonDir      = DataDir + '/json'
PidFile      = LogDir + '/raspirec.pid'
TimerPidFile = LogDir + '/timer.pid'
HttpdPidFile = LogDir + '/httpd.pid'

LogFname     = LogDir + '/raspirec.log'
StdoutM      = LogDir + "/main_out.log"  # main debug 標準出力ファイル
StderrM      = LogDir + "/main_err.log"  # main debug 標準エラーファイル
StdoutH      = LogDir + "/httpd_out.log" # httpd debug 標準出力ファイル
StderrH      = LogDir + "/httpd_err.log" # httpd debug 標準エラーファイル
StdoutT      = LogDir + "/timer_out.log" # timer debug 標準出力ファイル
StderrT      = LogDir + "/timer_err.log" # timer debug 標準エラーファイル


Debug =  false
Debug_mem  = false              # メモリの消費量の表示



