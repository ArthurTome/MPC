%% Script para Configuração da Simulação do Controlador MADRC (Modelo COMPLETO)
clear; clc; close all;

%% 1. Parâmetros e Modelos da Planta (FBC - Malha de Potência G11(s))
disp('1. Definindo parâmetros da planta FBC conforme o artigo...');
K = 8.1;   % Ganho da planta
T = 100;   % Constante de tempo da planta [s]
n = 5;     % Ordem da planta

% Coeficientes para a PLANTA REAL (5ª ordem) -> G_planta = K / (T*s + 1)^5
numerador_real = K;
den_poly = [T 1];
denominador_real = conv(den_poly, conv(den_poly, conv(den_poly, conv(den_poly, den_poly))));

% Coeficientes para o COMPENSADOR INTERNO (3ª ordem) -> Gcp = 1 / (T*s + 1)^3
numerador_gcp = 1;
den_poly_gcp = [T 1];
denominador_gcp = conv(den_poly_gcp, conv(den_poly_gcp, den_poly_gcp));

disp('----------------------------------------------------');
disp('Simulando o sistema COMPLETO:');
disp('Planta no modelo principal: 5ª Ordem');
disp('Compensador dentro do controlador: 3ª Ordem');
disp('----------------------------------------------------');

%% 2. Parâmetros do Controlador MADRC
disp('2. Usando os parâmetros de sintonia ORIGINAIS da Tabela 10 do artigo...');
% Período de amostragem [s]
Ts = 1;

% Parâmetros de sintonia da Tabela 10 para o "Controller 1"
omega_c = 0.022;
omega_o = 0.9;
b0 = 0.005;

% Ganhos do Controlador (SFCL) baseados em omega_c
kp = omega_c^2;
kd = 2 * omega_c;

% Ganhos do Observador (ESO) baseados em omega_o
beta1 = 3 * omega_o;
beta2 = 3 * omega_o^2;
beta3 = omega_o^3;

disp(['omega_c = ' num2str(omega_c)]);
disp(['omega_o = ' num2str(omega_o)]);
disp(['b0 = ' num2str(b0)]);

%% 3. Parâmetros da Simulação
disp('3. Definindo parâmetros da simulação...');
T_sim = 8000;
ref_inicial = 0;
ref_final = 26,4;
t_degrau = 50;

disp('Configuração concluída. Execute o modelo Simulink atualizado.');