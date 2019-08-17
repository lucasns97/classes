clear; close all;clc

function [S_variacao, I_variacao, R_variacao] = progredir(S, I, R, beta, gama, epsolon)
	
	% função 'passo' para variar os valores de S, I e R.

	N = S+I+R;
	
	S_variacao = -beta*S*I/N + epsolon*R;				
	I_variacao = beta*S*I/N - gama*I;
	R_variacao = gama*I - epsolon*R;
	
endfunction

function plotSIR(S, I, R, N, num_interacoes)

	% função para plotar a série temporal da resolução da EDO.
	
	t = [1:1:num_interacoes];
	
	hold on
	
	plot(t, S, 'y-', 'linewidth', 2.8)
	plot(t, I, 'r-', 'linewidth', 2.8)
	plot(t, R, 'b-', 'linewidth', 2.8)
	grid()
	title('Modelo SIR - simplificado');
	xlabel('tempo');
	ylabel('indivíduos');
	legend('Sucetiveis', 'Infectados', 'Recuperados');
	axis([0, num_interacoes, 0, N]);
	
	hold off
	
endfunction


% MAIN
% Declarando variáveis

num_interacoes = 100;
 
N = 100; % número de indivíduos inicial N = S + I + R 
S = zeros(num_interacoes,1); % succetíveis
I = zeros(num_interacoes,1); % infectados
R = zeros(num_interacoes,1); % recuperados

S(1) = 90; % número inicial de indivíduos succetíveis
I(1) = N - S(1); % número inicial de indivíduos infectados
R(1) = 0; % número inicial de indivíduos recuperados

printf("População sucetivel inicial: %d indivíduos\n", S(1)); 
printf("População infectada inicial: %d indivíduos\n", I(1));
printf("População recuperada inicial: %d indivíduos\n", R(1)); 


passo = 0.1;
beta = 1; % taxa média de contato entre indivíduos (infecciosidade)
gama = 1; % taxa de recuperação
epsolon = 0.1; % taxa de retorno a succetibilidade

for i=2 : num_interacoes
	
	[S_variacao I_variacao R_variacao] = progredir(S(i-1), I(i-1), R(i-1), beta, gama, epsolon);
	
	% adicionando mais um termo na série temporal de S, I e R

	S(i) = S(i-1) + passo * S_variacao; 
	I(i) = I(i-1) + passo * I_variacao;
	R(i) = R(i-1) + passo * R_variacao;
	
endfor

% plotando o gŕafico da série temporal de S, I e R

plotSIR(S, I, R, N, num_interacoes);