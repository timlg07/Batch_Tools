@echo off & setlocal enabledelayedexpansion
set "result=" & set /a this=0 & set /a next=1
set /p "Zahl[0]=Zahl: >"
set /a Zahl[0]+=0
:while
set /a Zahl[%next%]=!Zahl[%this%]!/2
set /a binary[%this%]=!Zahl[%this%]!%%2
set "result=!binary[%this%]!%result%"
set /a this+=1
set /a next+=1
if !Zahl[%this%]! NEQ 0 goto while
echo %Zahl[0]% in binaer: %result%
echo. & %0