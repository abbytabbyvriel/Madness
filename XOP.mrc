; Access script made by Tanmay.
; For help, do /server -m irc.rizon.net -j #me
; That will bring you to my channel and you can ask me for help there.
; Good luck and I hope this script helps you!

; This part will actually voice/halfop/op/admin/owner the person 
on *:JOIN:*: {
  if ($($+(%,$chan,.,XOP),2) == ON) {
    if ($($+(%,$nick,.,level,.,$chan),2) == voice) {
      /mode $chan +v $nick
    }
    if ($($+(%,$nick,.,level,.,$chan),2) == halfop) {
      /mode $chan +h $nick
    }
    if ($($+(%,$nick,.,level,.,$chan),2) == op) {
      /mode $chan +o $nick
    }
    if ($($+(%,$nick,.,level,.,$chan),2) == admin) {
      if ($($+(%,$nick,.,level,.,$chan),2) != owner) {
        /mode $chan +ao $nick $nick
      }
    }
    if ($($+(%,$nick,.,level,.,$chan),2) == owner) {
      /mode $chan +qo $nick $nick
    }
  }
}
; This part will allow you to add and remove people from the access list. 
on *:TEXT:*:#: {
  ; Change the below line to your name. If you want people who are already admin uncomment line 21 and comment line 20. 
  if ($1 == .xop) {
    if ($nick isop $chan) {
      if ($2 == on) {
        notice $nick XOP enabled.
        set $+(%,$chan,.,XOP) ON
        set $+(%,$nick,.,level,.,$chan) owner
        set $+(%,$nick,.,level,.,$chan,.,access) admin
      }
      if ($2 == off) {
        notice $nick XOP diabled.
        set $+(%,$chan,.,XOP) OFF
      }
    }
  }
  if ($2 != $null) {
    if ($($+(%,$nick,.,level,.,$chan,.,access),2) == admin) { 
      if ($1 == .avoice) {
        if ($($+(%,$2,.,level,.,$chan),2) != voice) {
          if ($($+(%,$2,.,level,.,$chan),2) == $null) {
            set $+(%,$2,.,level,.,$chan) voice
            notice $nick $2 will now be automatically voiced.
          }
          else {
            notice $nick Access for $2 changed from $($+(%,$2,.,level,.,$chan),2) to voice.
            set $+(%,$2,.,level,.,$chan) voice
            unset $+(%,$2,.,level,.,$chan,.,access)
          }
          else {
            notice $nick $2 is already going to be automatically voiced. Access unchanged.
          }
        }
      }
      if ($1 == .ahalfop) {
        if ($($+(%,$2,.,level,.,$chan),2) != halfop) {
          if ($($+(%,$2,.,level,.,$chan),2) == $null) {
            set $+(%,$2,.,level,.,$chan) halfop
            notice $nick $2 will be now automatically given halfop.
          } 
          else {
            notice $nick Access for $2 changed from $($+(%,$2,.,level,.,$chan),2) to halfop.
            set $+(%,$2,.,level,.,$chan) halfop
            unset $+(%,$2,.,level,.,$chan,.,access)
          }
        }
        else {
          notice $nick $2 is already going to be automatically halfop. Access unchanged.
        }
      }  
    }
    if ($1 == .aop) {
      if ($($+(%,$2,.,level,.,$chan),2) != op) {
        if ($($+(%,$2,.,level,.,$chan),2) == $null) {
          set $+(%,$2,.,level,.,$chan) op
          notice $nick $2 will now automatically be given op.
        } 
        else {
          notice $nick Access for $2 changed from $($+(%,$2,.,level,.,$chan),2) to op.
          set $+(%,$2,.,level,.,$chan) op
          unset $+(%,$2,.,level,.,$chan,.,access)
        }
        else {
          notice $nick $2 is already going to be automatically op. Access unchanged.
        }
      }  
    }
    if ($1 == .aadmin) {
      if ($($+(%,$2,.,level,.,$chan),2) != admin) {
        if ($($+(%,$2,.,level,.,$chan),2) == $null) {
          set $+(%,$2,.,level,.,$chan) admin
          set $+(%,$2,.,level,.,$chan,.,access) admin
          notice $nick $2 will now automatically be given admin.
        } 
        else {
          notice $nick Access for $2 changed from $($+(%,$2,.,level,.,$chan),2) to admin.
          set $+(%,$2,.,level,.,$chan) admin
          set $+(%,$2,.,level,.,$chan,.,access) admin
        }
      }
      else {
        notice $nick $2 is already going to be automatically admin. Access unchanged.
      }
    }  
  }
  if ($1 == .aowner) {
    if ($($+(%,$2,.,level,.,$chan),2) != owner) {
      if ($($+(%,$2,.,level,.,$chan),2) == $null) {
        set $+(%,$2,.,level,.,$chan) owner
        set $+(%,$2,.,level,.,$chan,.,access) admin
        notice $nick $2 will now automatically be given owner.
      } 
      else {
        notice $nick Access for $2 changed from $($+(%,$2,.,level,.,$chan),2) to owner.
        set $+(%,$2,.,level,.,$chan) owner
      }
      else {
        notice $nick $2 is already going to be automatically owner. Access unchanged.
      }
    }
  }  

  if ($1 == .rvoice) {
    if ($($+(%,$2,.,level,.,$chan),2) == voice) {
      unset $+(%,$2,.,level,.,$chan)
      notice $nick $2 will no longer automatically be voiced.
    }
    else {
      notice $nick $2 never had voice access!
    } 
  }
  if ($1 == .rhalfop) {
    if ($($+(%,$2,.,level,.,$chan),2) == halfop) {
      unset $+(%,$2,.,level,.,$chan)
      notice $nick $2 will no longer automatically be given halfop.
    }
    else {
      notice $nick $2 never had halfop access!
    } 
  }
  if ($1 == .rop) {
    if ($($+(%,$2,.,level,.,$chan),2) == op) {
      unset $+(%,$2,.,level,.,$chan)
      notice $nick $2 will no longer be automatically given op.
    }
    else {
      notice $nick $2 never had op access!
    }
  }
  if ($1 == .radmin) {
    if ($($+(%,$2,.,level,.,$chan),2) == admin) {
      unset $+(%,$2,.,level,.,$chan)
      unset $+(%,$2,.,level,.,$chan,.,access)
      notice $nick $2 will no longer be automatically given admin.
    }
    else {
      notice $nick $2 never had admin access!
    }
  }
  if ($1 == .rowner) {
    if ($($+(%,$2,.,level,.,$chan),2) == owner) {
      unset $+(%,$2,.,level,.,$chan) 
      notice $nick $2 will no longer be given owner.
      unset $+(%,$2,.,level,.,$chan,.,access)
    }
    else {
      notice $nick $2 never had owner access!
    }
  }
}

; That's all, thanks for your time!
;  I hope this helps you! Good luck!
