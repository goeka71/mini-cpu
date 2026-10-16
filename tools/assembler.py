import sys
in_path = sys.argv[1]
out_path = sys.argv[2]

in_file = open(in_path, 'r')
out_file = open(out_path, 'w')

while True : 
    l = in_file.readline() # in_file의 각 줄을 읽어서 l에 문자열로 저장
    if not l : break # l에 내용이 없으면(마지막 줄까지 읽으면) while문 탈출
    
    out = "" # 해당 줄의 변환 결과를 저장하는 문자열
    slist = l.split() # in_file의 한 줄을 공백 기준으로 분할하여 문자열 리스트로 저장
    
    # opcode 변환
    match slist[0] :
        case 'ADD': out += '0000'
        case 'SUB' : out += '0001'
        case 'AND' : out += '0010'
        case 'OR' : out += '0011'
        case 'ADDI' : out += '0100'
        case 'LD' : out += '0101'
        case 'ST' : out += '0110'
        case 'BEQ' : out += '0111'
        case 'BNE' : out += '1000'
        case _ : print("OPCODE를 읽을 수 없습니다.")
    out += '_'
    
    # 인자1 & 인자2 변환
    out += format(int(slist[1][1]), '03b') + '_'
    out += format(int(slist[2][1]), '03b') + '_'
    
    # 인자3 변환
    if (slist[0] in ['ADD', 'SUB', 'AND', 'OR']) : 
        out += format(int(slist[3][1]), '03b') + '000'
    else : 
        out += format(int(slist[3]) & 0b111111, '06b')
    
    out += '\n'
    
    out_file.write(out)

in_file.close()
out_file.close()