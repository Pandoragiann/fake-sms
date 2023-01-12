1   #!/bin/bash
2   NC='\033[0m'
3   RED='\033[1;38;5;196m'
4   GREEN='\033[1;38;5;040m'
5   ORANGE='\033[1;38;5;202m'
6   BLUE='\033[1;38;5;012m'
7   BLUE2='\033[1;38;5;032m'
8   PINK='\033[1;38;5;013m'
9   GRAY='\033[1;38;5;004m'
10  NEW='\033[1;38;5;154m'
11  YELLOW='\033[1;38;5;214m'
12  CG='\033[1;38;5;087m'
13  CP='\033[1;38;5;221m'
14  CPO='\033[1;38;5;205m'
15  CN='\033[1;38;5;247m'
16  CNC='\033[1;38;5;051m'
17
18  function banner(){
19  echo -e ${RED}"######################################################################"
20  echo -e ${CP}"                                                                     #"
21  echo -e ${CP}"                                                                     #"
22  echo -e ${CP}"                                                                     #"
23  echo -e ${CP}"                                                                     #"
24  echo -e ${CP}"                                                                     #"
25  echo -e ${BLUE}"                                                                     #"
26  echo -e ${BLUE}"     A small Tool To Send Messages Anonymously                       #"
27  echo -e ${RED}"   WARNING: Use this Tool Only For Educational Purpose               #"
28  echo -e ${RED}"             I Will Not Be Responsible For Your Shit                 #"
29  echo -e ${YELLOW}"            Coded By: Pandoragiann                                 #"
30  echo -e ${GREEN}"             https://twiter.com/pandoragiann                        #"
31  echo -e ${RED}"######################################################################"
32
33  }
34  resize -s 38 70 > /dev/null
35  function dependencies(){
36  echo -e ${PINK}
37  cat /etc/issue.net
38
39
40  echo "Checking dependencies configuration"
41  sleep 1
42  if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" !=""]]; then
43    echo ${RED}"No Internet Connection"
44    exit 1
45    else
46    echo -e ${GREEN} "\n[ √ ] Internet..........${GREEN}[ working ]"
47  fi
48  sleep 1
49  which curl > /dev/null 2>&1
50  if [ "$?" -eq "0" ]; then
51  echo -e ${GREEN} "\n[ √ ]  curl................${GREEN}[ found ]"
52  else
53  echo -e $red "[ X ] curl  -> ${RED}not found "
54  echo -e ${YELLOW} " [ ! ] Installing curl "
55  sudo apt-get install curl "
56  echo -e ${BLUE} "[ √ ] Done installing...."
57  fi
58  sleep 1
59  which git > /dev/null 2>&1
60  if [ "$?" -eq "0" ]; then
61  echo -e ${GREEN} "\n[ √ ] git............${GREEN}[ found ]"
62  else
63  echo -e $red "[ X ] git  -> ${RED}not found "
64  echo -e ${YELLOW} "[ ! ] installing git "
65  pkg update && pkg upgrade  > /dev/null 2>&1
66  pkg install git > /dev/null 2>&1
67  echo -e ${BLUE} "[ √  ] Done installing...."
68  which git > /dev/null 2>&1
69  sleep 1
70  fi
71  sleep 1
72  }
73
74  function printmsg(){
75  echo  -e ${RED}" Exiting FAKE-SMS SENDER... "
76  sleep 1
77  echo  -e ${ORANGE}" See You Next Time........."
78  exit
79  }
80
81  function instruction(){
82
83  echo  -e ${YELLOW}"\n1. Your Country Code Must Be Without "+"\n"
84  sleep 0.5
85  echo  -e ${BLUE}"2. Country Code Example: 92\n"
86  sleep 0.5
87  echo  -e ${ORANGE}"3. Your Phone Number Must Be Start Without 0\n"
88  sleep 0.5
89  echo  -e ${CNC}"4. Full usage: 92355310222\n"
90  sleep 0.5
91  echo  -e ${RED}"...........NOTE: Only One Text Message Is Allowed Per Day........\n"
92  sleep 0.5
93  echo  -e -n ${BLUE}"\nBack to SENDISMS OPTION: [y/n]: "
94  read back_press
95  if [ $back_press = "Y" ]; then
96          SENDSMS
97  elif [ $back_press = "n" ]; then
98               exit
99      fi
100
101
102  }
103
104  function SENDSMS() {
105      clear
106      banner
107      echo ""
108     echo -e ${ORANGE}"Enter Phone Number With Country Code Like (693666492)\n"
109     echo -e -n ${CP}"Enter Phone Number With Country Code: "
110
111     read num
112
113     echo " "
114     echo -e -n ${BLUE}"Enter Your Message: "
115
116     read msg
117
118
119   SMSVERIFY=$(curl -# -X POST https://textbelt.com/text --data-urlencode phone="$num" --data-urlencode message="$msg" -d key=textbelt)
120
121   if grep -q true <<<"$SMSVERIFY"
122
123   then
124
125     echo "  "
126     echo -e ${CNC}".....SUCCESS "
127     echo "  "
128     echo -e ${CNC}" -------------------------------------"
129     echo "$SMSVERIFY"
130     echo -e ${CNC}" -------------------------------------"
131     echo "  "
132     printmsg
133  else
134
135     echo "  "
136     echo -e ${RED}" FAIL"
137     echo "  "
138     echo -e ${CNC}" -------------------------------------"
139     echo "$SMSVERIFY"
140     echo -e ${CNC}" -------------------------------------"
141     echo "  "
142     printmsg
143  fi
144  }
145  function STATUSCHECK(){
146  echo -e -n ${ORANGE}"\nEnter Text ID (e.g 123456): "
147  read ID
148  STATUSCONFIRM=$(curl -# https://textbelt.com/status/"$ID")
149  echo -e ${PINK}" Final Response (JSON): "
150    echo "  "
151    echo -e $(PINK}" ----------------------------------------"
152    echo "$STATUSCONFIRM"
153    echo -e ${PINK}" ----------------------------------------"
154  }
155  trap ctrl_c INT
156  ctrl_c() {
157  clear
158  echo -e ${RED}"[*] (Ctrl + C ) Detected Trying To Exit... "
159  echo -e ${RED}"[*] Stopping Services... "
160  sleep 1
161  echo ""
162  echo -e ${YELLOW}"[*] Thanks For Using Fake-SMS developed by  +255693666492 :)"
163  exit
164  }
165
166
167  menu(){
168
169  clear
170  dependencies
171  clear
172  banner
173
174
175  echo -e " \n${NC}[${CG}"1"${NC}]${CNC} SEE USAGE "
176  echo -e "${NC}[${CG}"2"${NC}]${CNC} Send Fake SMS"
177  echo -e "${NC}[${CG}"3"${NC}]${CNC} CHECK SMS STATUS "
178  echo -e "${NC}[${CG}"4"${NC}]${CNC} EXIT "
179  echo  -e ${RED}"\n[+] Select: "
180  read play
181     if [ $play -eq 1 ]; then
182            instruction
183     elif [ $play -eq 2 ]; then
184            SENDSMS
185     elif [ $play -eq 3 ]; then
186            STATUSCHECK
187     elif [ $Play -eq 4 ]; then
188            exit
189
190        fi
191  }
192  menu
193  #coded by Pandoragiann Don't copy this code without giving me credit.





 