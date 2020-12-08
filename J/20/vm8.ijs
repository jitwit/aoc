coclass 'vm8'

create =: 3 : 0
 jmp =: ({:"1) 0&".;._2 y
 mem =: 3 {."1 ];._2 y
 hist =: (#mem) $ pc =: acc =: 0
 'ok'
)

run =: 3 : 0
 while. 1 do.
  if.     pc=#mem do. break.
  elseif. pc{hist do. break.
  else. hist =: 1 pc}hist
        select. pc{mem
        case. 'acc' do. pc =: pc+1 [ acc =: acc + pc{jmp
        case. 'jmp' do. pc =: pc+pc{jmp
        case. 'nop' do. pc =: pc + 1 end.
  end.
 end.
)

swap =: 3 : 0
 select. y{mem
 case. 'jmp' do. mem =: 'nop' y}mem
 case. 'nop' do. mem =: 'jmp' y}mem
 case. do. end.
)
