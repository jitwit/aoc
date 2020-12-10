.phony : phony $(days)

days = 1 2 3 5 10

run : $(d)
	time ./$(d) < ../../input/2020/$(d).in

% : %.c
	gcc -Wall -O2 -o $@ $<

tout : $(days)

clean :
	rm -f $(days) *~
