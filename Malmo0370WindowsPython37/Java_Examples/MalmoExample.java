import malmo.MissionSpec;
import malmo.MissionRecord;
import malmo.MalmoAgentHandler;

public class MalmoExample {

    public static void main(String[] args) {

        // Criar um novo agente
        MalmoAgentHandler agentHandler = new MalmoAgentHandler();

        // Criar uma nova missão
        MissionSpec missionSpec = new MissionSpec();

        // Definir as configurações da missão
        missionSpec.setTimeLimit(60000); // 60 segundos
        missionSpec.setRewardForReachingGoal(100); // 100 pontos por alcançar o objetivo

        // Carregar a missão
        agentHandler.loadMission(missionSpec);

        // Iniciar a missão
        agentHandler.startMission();

        // Obter o registro da missão
        MissionRecord missionRecord = agentHandler.getResult();

        // Imprimir o resultado da missão
        System.out.println("Sucesso da missão: " + missionRecord.wasSuccessful());
        System.out.println("Recompensa da missão: " + missionRecord.getReward());

        // Fechar o agente
        agentHandler.close();
    }
}
