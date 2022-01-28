class CameraController : sef::GameController
{
	//-----------
	private vector2 m_cameraMiddlePos;
	private vector2 m_cameraPos;
	private ETHEntity@ m_camMin;
	private ETHEntity@ m_camMax;
	vector2 camPos;
	vector2 camMin;
	vector2 camMax;	
	//-----------
	private sef::FollowerAsymptotic@ m_follower;

	CameraController()
	{
		@m_follower = sef::FollowerAsymptotic(GetCameraPos(), 0.035f, true /*dontPause*/);
		AddEntity("cam_min.ent", vector3(0.0f, 0.0f, 0.0f), m_camMin);
		AddEntity("cam_max.ent", vector3(7040.0f, GetScreenSize().y, 0.0f), m_camMax);
	}

	void update() override
	{
		m_follower.update();
		m_cameraMiddlePos = m_follower.getPos();

		camPos = m_cameraMiddlePos;
		camMin = m_camMin.GetPositionXY();
		camMax = m_camMax.GetPositionXY() - GetScreenSize();

		//limiting the camera
		m_cameraPos = sef::math::clamp(camPos, camMin, camMax);
		SetCameraPos(m_cameraPos);
	}

	void setDest(const vector2 &in dest)
	{
		m_follower.setDestinationPos(dest - (GetScreenSize() * 0.5f));
	}

	void draw() override {}
}
