if ~isempty(timerfind)
    stop(timerfind);
    delete(timerfind);
end
global t
t = 0;
tmr = timer;
set(tmr,'ExecutionMode','fixedRate');   
set(tmr,'Period',0.1);
set(tmr,'BusyMode','queue');
set(tmr,'TimerFcn','timer_con');  
start(tmr);