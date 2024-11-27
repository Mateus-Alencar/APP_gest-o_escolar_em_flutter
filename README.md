# Sistema de Gestão de Educadores

O aplicativo é um sistema de gestão de educadores que permite o cadastro de novos professores, incluindo informações detalhadas como nome completo, e-mail, telefone, papel, período de trabalho e a classe associada. 

Com funcionalidades de busca, os usuários podem localizar educadores rapidamente por nome, período ou classe. Além disso, o sistema possibilita a edição de informações, permitindo que dados como e-mail, telefone ou período de trabalho sejam atualizados conforme necessário. 

Caso seja preciso, educadores também podem ser excluídos da base de dados. Para facilitar a navegação, filtros de pesquisa permitem refinar os resultados com base no período e na classe. O sistema conta ainda com um mecanismo de autenticação, garantindo segurança no acesso às informações.

# Requisitos Funcionais

1. **Cadastro de Educadores**  
   O sistema deve permitir o cadastro de novos educadores, contendo informações como nome completo, e-mail, telefone, papel, período e classe.

2. **Busca de Educadores**  
   O sistema deve permitir a busca de educadores por nome, período ou classe.

3. **Edição de Educadores**  
   O usuário poderá selecionar um educador e editar suas informações, como nome, e-mail, telefone, período e classe.

4. **Exclusão de Educadores**  
   O sistema deve permitir que educadores sejam excluídos da base de dados.

5. **Filtros de Pesquisa**  
   Deve ser possível filtrar educadores por período e classe.

6. **Autenticação**  
   O sistema deve realizar autenticação dos usuários no aplicativo.

   # Requisitos Não Funcionais

1. **Usabilidade**  
   A interface deve ser intuitiva, facilitando a navegação e interação com o sistema.

2. **Autenticação**  
   - Permitir que o usuário faça login com e-mail e senha de forma segura.  
   - Validar as credenciais e autenticar usuários antes de conceder acesso ao aplicativo.

3. **Visualização**  
   Mostrar a lista de educadores e as turmas associadas a cada um.

4. **Confiabilidade**  
   O sistema deve manter a integridade dos dados durante operações de cadastro, edição e exclusão.

5. **Escalabilidade**  
   A arquitetura do sistema deve permitir a expansão futura para incluir novas funcionalidades sem degradação de performance.

6. **Disponibilidade**  
   O sistema deve estar disponível para acesso a qualquer momento, com mínimo de tempo de inatividade.


# Tecnologias Utilizadas

**Flutter**  
Utilizei o Flutter para desenvolver a interface do usuário do aplicativo, aproveitando seus recursos de alto desempenho e widgets personalizáveis, o que permite criar aplicativos nativos para Android e iOS com uma única base de código.

**Supabase**  
O Supabase foi escolhido como o backend do aplicativo, proporcionando uma solução simples e eficaz para gerenciar dados e autenticação de usuários.

**Visual Studio Code**  
O Visual Studio Code foi a IDE utilizada para o desenvolvimento, oferecendo recursos como suporte a Flutter, Dart e SQL, além de ferramentas de depuração e controle de versão que facilitam o processo de codificação e integração com o Supabase.



