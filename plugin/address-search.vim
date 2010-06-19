fun! CompleteEmails(findstart, base)
    if a:findstart
        let line = getline('.')
        "locate the start of the word
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '[^:,]'
            let start -= 1
        endwhile
        return start
    else
        " find the addresses ustig the external tool
        " the tools must give properly formated email addresses
        let res = []
        for m in split(system('mutt-evo-query -r  ' . shellescape(a:base)), '\n')
                call add(res, m)
        endfor
        return res
    endif
endfun

fun! UserComplete(findstart, base)
    " Fetch current line
    let line = getline(line('.'))
    " Is it a special line?
    if line =~ '^\(To\|Cc\|Bcc\|From\|Reply-To\):'
        return CompleteEmails(a:findstart, a:base)
    endif
endfun

set completefunc=UserComplete
