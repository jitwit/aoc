.phony : phony $(days)

days = 1 2 3

run : 0$(d)
	time ./0$(d) < ../../input/2020/$(d).in

% : %.c
	gcc -Wall -O2 -o $@ $<

tout : $(addprefix 0,$(days))

clean :
	rm -f $(addprefix 0,$(days)) *~
