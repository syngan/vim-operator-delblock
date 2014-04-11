filetype plugin on

scriptencoding utf-8

map <silent>sd <Plug>(operator-delblock-)
let g:__ = 'koreha dummy string __'
let g:_f = 'koreha dummy string _f'

function! s:paste_code(lines)
  put =a:lines
  1 delete _
endfunction

describe 'del-char'
  before
    new
    call setreg('"', g:__, 'v')
    call setreg('f', g:_f, 'v')
  end

  after
    close!
  end

  it '1line'
    call s:paste_code(['hoge(tako)'])
    normal! gg0
    execute 'normal' "\<Plug>(operator-delblock)f)"
    normal! gg0
    execute 'normal' "sdf)"
    Expect line('$') == 1
    Expect getreg('"') == g:__
    Expect getreg('f') == g:_f
    Expect getline(1) == 'tako'
  end

end


" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:
